<?php

namespace App\Controller;

use App\Entity\Membre;
use Symfony\Component\Mime\Email;
use App\Form\RegistrationFormType;
use App\Repository\MembreRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\Translation\TranslatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class RegistrationController extends AbstractController
{
    private function generateToken()
    {
        return rtrim(strtr(base64_encode(random_bytes(32)), '+/', '-_'), '=');
    }

    #[Route('/inscription/afficher', name: 'inscription_afficher')]
    public function afficherFormulaire(Request $request, UserPasswordHasherInterface $userPasswordHasher, EntityManagerInterface $entityManager): Response
    {
        $user = new Membre();
        $form = $this->createForm(RegistrationFormType::class, $user);
        $form->handleRequest($request);
        // dd($user);

        return $this->render('registration/register.html.twig', [
            'registrationForm' => $form->createView(),
        ]);
    }

    #[Route('/inscription/traiter', name: 'inscription_traiter', methods: 'POST')]
    public function traiterFormulaire(Request $request, UserPasswordHasherInterface $userPasswordHasher, EntityManagerInterface $entityManager, MailerInterface $mailer): Response
    {
        $user = new Membre();
        $form = $this->createForm(RegistrationFormType::class, $user);
        $form->handleRequest($request);
        // dd($user);
        if ($form->isSubmitted() && $form->isValid()) {
            // encode the plain password
            $user->setPassword(
                $userPasswordHasher->hashPassword(
                    $user,
                    $form->get('plainPassword')->getData()
                )
            )
                ->setDateEnregistrement(new \Datetime)
                ->setActive(0)
                ->setToken($this->generateToken());

            $entityManager->persist($user);
            $entityManager->flush();
            // do anything else you need here, like send an email
            // ! envoyer un email

            $email = (new TemplatedEmail())
                ->from('test@example.com')
                ->to($user->getEmail())
                //->cc('cc@example.com')
                //->bcc('bcc@example.com')
                //->replyTo('fabien@example.com')
                //->priority(Email::PRIORITY_HIGH)
                ->subject("Activer votre compte t_shop")
                ->htmlTemplate('email/validateAccount.html.twig')
                ->context([
                    'user' => $user
                ]);

            $mailer->send($email);


                    // !fin de l'envoi

            return $this->redirectToRoute('app_app');
        }

        return $this->render('registration/register_traitement.html.twig', [
            'registrationForm' => $form->createView(),
        ]);
    }

    #[Route('/validate/account/{token}', name:'validate_account')]
    public function validateAccount($token, MembreRepository $repo, EntityManagerInterface $manager)
    {
        $user = $repo->findOneBy(['token' => $token]);
        if($user)
        {
            $user->setActive(1)
            ->setToken(null);
            $manager->persist($user);
            $manager->flush();
            return $this->render('registration/valider.html.twig');
        }
        else
        {
            return $this->redirectToRoute('app_app');
        }
    }
}
