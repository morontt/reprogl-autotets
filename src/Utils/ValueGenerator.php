<?php

declare(strict_types=1);

/**
 * User: morontt
 * Date: 21.04.26
 * Time: 08:00
 */

namespace Reprogl\Utils;

class ValueGenerator
{
    public function handle(string $value): mixed
    {
        $matches = [];
        if (preg_match('/^#{([^}]+)}$/', $value, $matches)) {
            $placeholder = $matches[1];
        } else {
            throw new \RuntimeException('Unsupported value: ' . $value);
        }

        $result = null;
        switch (true) {
            case 'randomComment' === $placeholder:
                $result = sprintf(
                    '%s%s %s%s',
                    str_pad((string)mt_rand(0, 999), 3, '0', STR_PAD_LEFT),
                    str_pad((string)mt_rand(0, 999), 3, '0', STR_PAD_LEFT),
                    str_pad((string)mt_rand(0, 999), 3, '0', STR_PAD_LEFT),
                    str_pad((string)mt_rand(0, 999), 3, '0', STR_PAD_LEFT),
                );
                break;
            default:
                throw new \RuntimeException('Not implemented: ' . $placeholder);
        }

        return $result;
    }

    public function support(string $value): bool
    {
        return (bool)preg_match('/^#{[^}]+}$/', $value);
    }
}
