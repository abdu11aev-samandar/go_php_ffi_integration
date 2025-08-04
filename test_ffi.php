<?php

class GoLib 
{
    private $ffi;
    
    public function __construct() 
    {
        $header = file_get_contents(__DIR__ . '/simple.h');
        $this->ffi = FFI::cdef($header, __DIR__ . '/golib.so');
    }
    
    public function addNumbers($a, $b) 
    {
        return $this->ffi->add_numbers($a, $b);
    }
    
    public function createUser($name, $age) 
    {
        $result = $this->ffi->create_user($name, $age);
        $json = FFI::string($result);
        $this->ffi->free_string($result);
        return json_decode($json, true);
    }
}

// Test
echo "Go + PHP FFI Test\n";
echo "=================\n\n";

$go = new GoLib();

// Test 1
echo "Adding: 15 + 27 = " . $go->addNumbers(15, 27) . "\n\n";

// Test 2
$user = $go->createUser("Ali", 25);
echo "User: " . json_encode($user) . "\n\n";

echo "✅ Success!\n";
