<?php

declare(strict_types=1);

/**
 * User: morontt
 * Date: 09.04.26
 * Time: 09:33
 */

namespace Reprogl\Context;

use Behat\Behat\Hook\Scope\AfterStepScope;
// use Behat\Behat\Tester\Exception\PendingException;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Step\Given;
use Behat\Step\Then;
use Behat\Step\When;
use Reprogl\Utils\ValueGenerator;

class FeatureContext extends MinkContext
{
    private ValueGenerator $generator;
    private array $parameters = [];

    public function __construct()
    {
        $this->generator = new ValueGenerator();
    }

    #[When('I logged in as :username')]
    public function iLoggedInAsUsername(string $username)
    {
        $this->visit('/admin/login');
        $this->fillField('_username', $username);
        $this->fillField('_password', 'test');
        $this->pressButton('login');
    }

    /**
     * @AfterStep
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

    #[Given('I assign parameters with data:')]
    public function iAssignParametersWithData(TableNode $table): void
    {
        foreach ($table->getHash() as $row) {
            $value = $row['value'];
            if ($this->generator->support($value)) {
                $value = $this->generator->handle($value);
            }

            $this->parameters[$row['key']] = $value;
        }
    }

    #[When('I fill in :field with value :value')]
    public function iFillInWithValue($field, $value): void
    {
        $value = $this->fixStepArgument($value);

        $this->fillField($field, $this->getContextValue($value));
    }

    #[Then('I should see value :value in the :element element')]
    public function iShouldSeeValueInTheElement($value, $element): void
    {
        $value = $this->fixStepArgument($value);

        $this->assertSession()->elementTextContains('css', $element, $this->getContextValue($value));
    }

    #[Then('I should not see value :value in the :element element')]
    public function iShouldNotSeeValueInTheElement($value, $element): void
    {
        $value = $this->fixStepArgument($value);

        $this->assertSession()->elementTextNotContains('css', $element, $this->getContextValue($value));
    }

    private function getContextValue(string $value): mixed
    {
        if (preg_match('/\$[A-Za-z_]+/', $value)) {
            $result = preg_replace_callback(
                '/\$(?P<variable>[A-Za-z_]+)/',
                function ($matches) {
                    if (isset($this->parameters[$matches['variable']])) {
                        return $this->parameters[$matches['variable']];
                    }

                    throw new \RuntimeException('Undefined variable: ' . $matches['variable']);
                },
                $value
            );
        } else {
            $result = $value;
        }

        return $result;
    }
}
