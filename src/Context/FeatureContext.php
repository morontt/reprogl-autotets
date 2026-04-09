<?php

declare(strict_types=1);

/**
 * User: morontt
 * Date: 09.04.26
 * Time: 09:33
 */

namespace Reprogl\Context;

use Behat\Behat\Hook\Scope\AfterStepScope;
use Behat\MinkExtension\Context\MinkContext;

class FeatureContext extends MinkContext
{
    /**
     * @When I logged in as :username
     */
    public function iLoggedInAsUsername(string $username)
    {
        $this->visit('/admin/login');
        $this->fillField('_username', $username);
        $this->fillField('_password', 'test');
        $this->pressButton('login');
    }

    /**
     * @AfterStep
     *
     * @param AfterStepScope $event
     */
    public function printLastResponseOnError(AfterStepScope $event)
    {
        if (!$event->getTestResult()->isPassed()) {
            file_put_contents(
                dirname(__DIR__, 2) . '/var/artifacts/' . time() . '_' . uniqid() . '.html',
                $this->getSession()->getDriver()->getContent()
            );
        }
    }
}
