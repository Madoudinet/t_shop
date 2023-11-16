<?php

namespace App\Controller;

use Stripe\Stripe;
use App\Service\CartService;
use Stripe\Checkout\Session;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

// use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class PayementController extends AbstractController
{

    private UrlGeneratorInterface $generator;

    public function __construct(UrlGeneratorInterface $generator)
    {
        $this->generator = $generator;
    }

    #[Route('/payement/create-session-stripe', name: 'payment_stripe')]
    public function stripeCheckout(CartService $cs): RedirectResponse
    {
        $cartWithData = $cs->cartWithData();
        // dd($cartWithData);
        Stripe::setApiKey($_ENV['STRIPE_PRIVATE_KEY_TEST']);

        //* Création de notre tableau vide
        $produitStripe = [];

        // *Parcourir notre panier et remplir le tableau de produit pour stripe
        foreach($cartWithData as $data)
        {
            $produitStripe[] = [
                'price_data' => [
                    'currency' => 'eur',
                    'unit_amount' => $data['produit']->getPrix(),
                    'product_data' => [
                        'name' => $data['produit']->getTitre(),
                    ],
                ],
                    'quantity' => $data['quantity'],
            ];
        }
        // dd($produitStripe);
        $checkout_session = Session::create([
            'customer_email' => $this->getUser()->getEmail(),
            'payment_method_types' => ['card'],
            'line_items' => [[
                $produitStripe,
            ]],
            'mode' => 'payment',
            'success_url' => $this->generator->generate('payment_success', [], UrlGeneratorInterface::ABSOLUTE_URL),
            'cancel_url' =>  $this->generator->generate('payment_error', [], UrlGeneratorInterface::ABSOLUTE_URL),
            ]);

            return new RedirectResponse($checkout_session->url);
    }

    #[Route('/payment/success', name:'payment_success')]
    public function stripeSuccess() : Response
    {
        return $this->redirectToRoute('cart_commande');
    }

    #[Route('/payment/success', name:'payment_error')]
    public function stripeError() : Response
    {
        $this->addFlash('danger', 'payment non effectué');
        return $this->redirectToRoute('app_cart');
    }
}
