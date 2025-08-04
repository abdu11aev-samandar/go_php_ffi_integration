package main

/*
#include <stdlib.h>
*/
import "C"
import (
	"encoding/json"
	"unsafe"
)

type User struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
	Age  int    `json:"age"`
}

//export add_numbers
func add_numbers(a, b C.int) C.int {
	return a + b
}

//export create_user
func create_user(name *C.char, age C.int) *C.char {
	user := User{
		ID:   1,
		Name: C.GoString(name),
		Age:  int(age),
	}
	
	jsonBytes, _ := json.Marshal(user)
	return C.CString(string(jsonBytes))
}

//export free_string
func free_string(str *C.char) {
	C.free(unsafe.Pointer(str))
}

func main() {}
