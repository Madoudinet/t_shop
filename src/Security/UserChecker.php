<?php

namespace App\Security;

use App\Entity\Membre;
use Symfony\Component\Security\Core\Exception\CustomUserMessageAuthenticationException;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\User\UserCheckerInterface;

class UserChecker implements UserCheckerInterface
{
    public function checkPreAuth(UserInterface $user)
    {
        if( !$user instanceof Membre)
        {
            return;
        }

        if(!$user->isActive() == true)
        {
            throw new CustomUserMessageAuthenticationException(
                "Le compte n'est pas activé. Regardez vos emails"
            );
        }
    }

    public function checkPostAuth(UserInterface $user)
    {
        $this->checkPreAuth($user);
    }
}