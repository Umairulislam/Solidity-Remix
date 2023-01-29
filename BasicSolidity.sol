// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.3 and less than 0.9.0
pragma solidity ^0.8.3;

// 2.BASIC SYNTAX
// contract HelloWorld {
//     string public greet = "Hello World!";
// }

// ASSIGNMENT
// 1.Delete the HelloWorld contract and its content.
// 2.Create a new contract named "MyContract".
// 3.The contract should have a public state variable called "name" of the type string.
// 4.Assign the value "Alice" to your new variable.
// ANSWERS
// contract MyContract {
//     string public name = "Alice";
// }

// 3. PRIMITIVE DATA TYPES
contract Primitives {
    bool public boo = true;

    /*
    uint stands for unsigned integer, meaning non negative integers
    different sizes are available
        uint8   ranges from 0 to 2 ** 8 - 1
        uint16  ranges from 0 to 2 ** 16 - 1
        ...
        uint256 ranges from 0 to 2 ** 256 - 1
    */
    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123; // uint is an alias for uint256

    /*
    Negative numbers are allowed for int types.
    Like uint, different ranges are available from int8 to int256
    */
    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123; // int is same as int256

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    // Default values
    // Unassigned variables have a default value
    bool public defaultBoo; // false
    uint256 public defaultUint; // 0
    int256 public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000

    // ASSIGNMENT
    // 1.Create a new variable newAddr that is a public address and give it a value that is not the same as the available variable addr.
    // 2.Create a public variable called neg that is a negative number, decide upon the type.
    // 3.Create a new variable, newU that has the smallest uint size type and the smallest uint value and is public.
    // ANSWERS
    address public newAddr = 0x2875Ef2C342489a9D20A093A6791DD7700A9C00c;
    int256 public neg = -4;
    uint8 public newU = 0;
}

// 4. VARIABLES
contract Variables {
    // State variables are stored on the blockchain.
    string public text = "Hello";
    uint256 public num = 123;

    function doSomething() public {
        // Local variables are not saved to the blockchain.
        uint256 i = 456;

        // Here are some global variables
        uint256 timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address of the caller

        blockNumber = block.number;
    }

    uint256 public blockNumber;

    // ASSIGNMENT
    // 1.Create a new public state variable called blockNumber.
    // 2.Inside the function doSomething(), assign the value of the current
    // block number to the state variable blockNumber.
    // ANSWER
    // uint256 public blockNumber;
    // blockNumber = block.number;
}

// 5.1.FUNCTIONS | READING AND WRITNG TO A STATE VARIABLE
contract SimpleStorage {
    // State variable to store a number
    uint256 public num;

    // You need to send a transaction to write to a state variable.
    function set(uint256 _num) public {
        num = _num;
    }

    // You can read from a state variable without sending a transaction.
    function get() public view returns (uint256) {
        return num;
    }

    // ASSIGNMENT
    // 1.Create a public state variable called b that is of type bool and initialize it to true.
    // 2.Create a public function called get_b that returns the value of b.
    // ANSWER
    bool public b = true;

    function get_b() public view returns (bool) {
        return b;
    }
}

// 5.2.FUNCTIONS | VIEW AND PURE
contract ViewAndPure {
    uint256 public x = 1;

    // Promise not to modify the state.
    function addToX(uint256 y) public view returns (uint256) {
        return x + y;
    }

    // Promise not to modify or read from the state.
    function add(uint256 i, uint256 j) public pure returns (uint256) {
        return i + j;
    }

    // ASSIGNMENT
    // 1.Create a function called addToX2 that takes the parameter y and updates the state variable x with the sum of the parameter and the state variable x.
    // ANSWER
    function addToX2(uint256 y) public {
        x = x + y;
    }
}

// 5.3.FUNCTIONS |
contract FunctionModifier {
    // We will use these variables to demonstrate how to use
    // modifiers.
    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        // Set the transaction sender as the owner of the contract.
        owner = msg.sender;
    }

    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    // Modifiers can take inputs. This modifier checks that the
    // address passed in is not the zero address.
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validAddress(_newOwner)
    {
        owner = _newOwner;
    }

    // Modifiers can be called before and / or after a function.
    // This modifier prevents a function from being called while
    // it is still executing.
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }

    // ASSIGNMENT
    // 1.Create a new function, increaseX in the contract. The function should take an input parameter of type uint and increase the value of the variable x by the value of the input parameter.
    // 2.Make sure that x can only be increased.
    // 3.The body of the function increaseX should be empty.
    // ANSWER
    function increaseX(uint256 y)
        public
        onlyOwner
        biggerThan0(y)
        increaseXbyY(y)
    {}
}

// 5.4.FUNCTIONS | INPUTS AND OUTPUTS
contract Function {
    // Functions can return multiple values.
    function returnMany()
        public
        pure
        returns (
            uint256,
            bool,
            uint256
        )
    {
        return (1, true, 2);
    }

    // Return values can be named.
    function named()
        public
        pure
        returns (
            uint256 x,
            bool b,
            uint256 y
        )
    {
        return (1, true, 2);
    }

    // Return values can be assigned to their name.
    // In this case the return statement can be omitted.
    function assigned()
        public
        pure
        returns (
            uint256 x,
            bool b,
            uint256 y
        )
    {
        x = 1;
        b = true;
        y = 2;
    }

    // Use destructing assignment when calling another
    // function that returns multiple values.
    function destructingAssigments()
        public
        pure
        returns (
            uint256,
            bool,
            uint256,
            uint256,
            uint256
        )
    {
        (uint256 i, bool b, uint256 j) = returnMany();

        // Values can be left out.
        (uint256 x, , uint256 y) = (4, 5, 6);

        return (i, b, j, x, y);
    }

    // Cannot use map for neither input nor output

    // Can use array for input
    function arrayInput(uint256[] memory _arr) public {}

    // Can use array for output
    uint256[] public arr;

    function arrayOutput() public view returns (uint256[] memory) {
        return arr;
    }

    // ASSIGNMENT
    // Create a new function called returnTwo that returns the values -2 and true without using a return statement.
    // ANSWER
    function returnTwo() public pure returns (int256 i, bool b) {
        i = -2;
        b = true;
    }
}

// 6. VISIBILITY
contract Base {
    // Private function can only be called
    // - inside this contract
    // Contracts that inherit this contract cannot call this function.
    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }

    // Internal function can be called
    // - inside this contract
    // - inside contracts that inherit this contract
    function internalFunc() internal pure returns (string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    // Public functions can be called
    // - inside this contract
    // - inside contracts that inherit this contract
    // - by other contracts and accounts
    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }

    // External functions can only be called
    // - by other contracts and accounts
    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    // This function will not compile since we're trying to call
    // an external function here.
    // function testExternalFunc() public pure returns (string memory) {
    //     return externalFunc();
    // }

    // State variables
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
    // State variables cannot be external so this code won't compile.
    // string external externalVar = "my external variable";
}

contract Child is Base {
    // Inherited contracts do not have access to private functions
    // and state variables.
    // function testPrivateFunc() public pure returns (string memory) {
    //     return privateFunc();
    // }

    // Internal function can be called inside child contracts.
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }

    // ASSIGNMENT
    // Create a new function in the Child contract called testInternalVar that returns the values of
    // all state variables from the Base contract that are possible to return.
    // ANSWER
    function testInternalVar()
        public
        view
        returns (string memory, string memory)
    {
        return (internalVar, publicVar);
    }
}

// 7.1 CONTROL FLOW | IF-ELSE
contract IfElse {
    function foo(uint256 x) public pure returns (uint256) {
        if (x < 10) {
            return 0;
        } else if (x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint256 _x) public pure returns (uint256) {
        // if (_x < 10) {
        //     return 1;
        // }
        // return 2;

        // shorthand way to write if / else statement
        return _x < 10 ? 1 : 2;
    }

    // ASSIGNMENT
    // Create a new function called evenCheck in the IfElse contract:
    // 1. That takes in a uint as an argument.
    // 2. The function returns true if the argument is even, and false if the argument is odd.
    // 3. Use a ternery operator to return the result of the evenCheck function.
    // ANSWER
    function evenCheck(uint256 y) public pure returns (bool) {
        return y % 2 == 0 ? true : false;
    }
}

// 7.2 CONTROL FLOW | LOOPS
contract Loop {
    uint256 public count;

    function loop() public {
        // for loop
        for (uint256 i = 0; i < 10; i++) {
            if (i == 5) {
                // Skip to next iteration with continue
                continue;
            }
            if (i == 5) {
                // Exit loop with break
                break;
            }
            count++;
        }

        // while loop
        uint256 j;
        while (j < 10) {
            j++;
        }
    }

    // ASSIGNMENT
    // 1.Create a public uint state variable called count in the Loop contract.
    // 2.At the end of the for loop, increment the count variable by 1.
    // 3.Try to get the count variable to be equal to 9, but make sure you don’t edit the break statement.
}

// 8.1 DATA STRUCTURES | ARRAYS
contract Array {
    // Several ways to initialize an array
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    // Fixed sized array, all elements initialize to 0
    uint256[10] public myFixedSizeArr;

    // ANSWER
    uint256[3] public arr3 = [0, 1, 2];

    function get(uint256 i) public view returns (uint256) {
        return arr[i];
    }

    // Solidity can return the entire array.
    // But this function should be avoided for
    // arrays that can grow indefinitely in length.
    // function getArr() public view returns (uint[] memory) {
    //     return arr;
    // }

    // ANSWER
    function getArr() public view returns (uint256[3] memory) {
        return arr3;
    }

    function push(uint256 i) public {
        // Append to array
        // This will increase the array length by 1.
        arr.push(i);
    }

    function pop() public {
        // Remove last element from array
        // This will decrease the array length by 1
        arr.pop();
    }

    function getLength() public view returns (uint256) {
        return arr.length;
    }

    function remove(uint256 index) public {
        // Delete does not change the array length.
        // It resets the value at index to it's default value,
        // in this case 0
        delete arr[index];
    }
}

contract CompactArray {
    uint256[] public arr;

    // Deleting an element creates a gap in the array.
    // One trick to keep the array compact is to
    // move the last element into the place to delete.
    function remove(uint256 index) public {
        // Move the last element into the place to delete
        arr[index] = arr[arr.length - 1];
        // Remove the last element
        arr.pop();
    }

    function test() public {
        arr.push(1);
        arr.push(2);
        arr.push(3);
        arr.push(4);
        // [1, 2, 3, 4]

        remove(1);
        // [1, 4, 3]

        remove(2);
        // [1, 4]
    }

    // ASSIGNMENT
    // 1.Initialize a public fixed-sized array called arr3 with the values 0, 1, 2. Make the size as small as possible.
    // 2.Change the getArr() function to return the value of arr3.
}

// 8.2 DATA STRUCTURES | MAPPING
pragma solidity ^0.8.3;

contract Mapping {
    // Mapping from address to uint
    mapping(address => uint256) public myMap;

    // ANSWER
    mapping(address => uint256) public balances;

    function get(address _addr) public view returns (uint256) {
        // Mapping always returns a value.
        // If the value was never set, it will return the default value.
        return balances[_addr];
    }

    function set(address _addr, uint256 _balance) public {
        // Update the value at this address
        balances[_addr] = _balance;
    }

    function remove(address _addr) public {
        // Reset the value to the default value.
        delete balances[_addr];
    }
}

contract NestedMapping {
    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _addr1, uint256 _i) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized
        return nested[_addr1][_i];
    }

    function set(
        address _addr1,
        uint256 _i,
        bool _boo
    ) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint256 _i) public {
        delete nested[_addr1][_i];
    }

    // ASSIGNMENT
    // 1.Create a public mapping balances that associates the key type address with the value type uint.
    // 2.Change the functions get and remove to work with the mapping balances.
    // 3.Change the function set to create a new entry to the balances mapping
}

// 8.3 DATA STRUCTURES | STRUCTS
contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // An array of 'Todo' structs
    Todo[] public todos;

    function create(string memory _text) public {
        // 3 ways to initialize a struct
        // - calling it like a function
        todos.push(Todo(_text, false));

        // key value mapping
        todos.push(Todo({text: _text, completed: false}));

        // initialize an empty struct and then update it
        Todo memory todo;
        todo.text = _text;
        // todo.completed initialized to false

        todos.push(todo);
    }

    // Solidity automatically created a getter for 'todos' so
    // you don't actually need this function.
    function get(uint256 _index)
        public
        view
        returns (string memory text, bool completed)
    {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // update text
    function update(uint256 _index, string memory _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // update completed
    function toggleCompleted(uint256 _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }

    // ASSIGNMENT
    // Create a function remove that takes a uint as a parameter and
    // deletes a struct member with the given index in the todos mapping.
    // ANSWER
    function remove(uint256 _index) public {
        delete todos[_index];
    }
}

// 8.4 DATA STRUCTURES | ENUMS
contract Enum {
    // Enum representing shipping status
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // Default value is the first element listed in
    // definition of the type, in this case "Pending"
    Status public status;

    // Returns uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view returns (Status) {
        return status;
    }

    // Update status by passing uint into input
    function set(Status _status) public {
        status = _status;
    }

    // You can update to a specific enum like this
    function cancel() public {
        status = Status.Canceled;
    }

    // delete resets the enum to its first value, 0
    function reset() public {
        delete status;
    }

    // ASSIGNMENT
    // 1.Define an enum type called Size with the members S, M, and L.
    // 2.Initialize the variable sizes of the enum type Size.
    // 3.Create a getter function getSize() that returns the value of the variable sizes.
    // ANSWER
    enum Size {
        S,
        M,
        L
    }

    Size public sizes;

    function getSize() public view returns (Size) {
        return sizes;
    }
}

// 9. DATA LOCATIONS
contract DataLocations {
    uint256[] public arr;
    mapping(uint256 => address) map;
    struct MyStruct {
        uint256 foo;
    }
    mapping(uint256 => MyStruct) myStructs;

    function f()
        public
        returns (
            MyStruct memory,
            MyStruct memory,
            MyStruct memory
        )
    {
        // call _f with state variables
        _f(arr, map, myStructs[1]);
        // get a struct from a mapping
        MyStruct storage myStruct = myStructs[1];
        // changing vlaue of variable
        myStruct.foo = 4;
        // create a struct in memory
        MyStruct memory myMemStruct = MyStruct(0);
        // new struct
        MyStruct memory myMemStruct2 = myMemStruct;
        myMemStruct2.foo = 1;
        // new struct
        MyStruct memory myMemStruct3 = myStruct;
        myMemStruct3.foo = 3;
        return (myStruct, myMemStruct2, myMemStruct3);
    }

    function _f(
        uint256[] storage _arr,
        mapping(uint256 => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // do something with storage variables
    }

    // You can return memory variables
    function g(uint256[] memory _arr) public returns (uint256[] memory) {
        // do something with memory array
    }

    function h(uint256[] calldata _arr) external {
        // do something with calldata array
    }

    // ASSIGNMENT
    // 1.Change the value of the myStruct member foo, inside the function f, to 4.
    // 2.Create a new struct myMemStruct2 with the data location memory inside the function f and assign it the
    // value of myMemStruct. Change the value of the myMemStruct2 member foo to 1.
    // 3.Create a new struct myMemStruct3 with the data location memory inside the function f and assign it
    // the value of myStruct. Change the value of the myMemStruct3 member foo to 3.
    // 4.Let the function f return myStruct, myMemStruct2, and myMemStruct3.
}

// 10.1 TRANSACTIONS | ETHER AND GWEI
contract EtherUnits {
    uint256 public oneWei = 1 wei;
    // 1 wei is equal to 1
    bool public isOneWei = 1 wei == 1;

    uint256 public oneEther = 1 ether;
    // 1 ether is equal to 10^18 wei
    bool public isOneEther = 1 ether == 1e18;

    uint256 public oneGwei = 1 gwei;
    bool public isOneGwei = 1 gwei == 1e9;
}

// 10.2 TRANSACTIONS | GAS AND GAS PRICE
contract Gas {
    uint256 public i = 0;
    // ASSIGNMENT
    uint256 public cost = 170367;

    // Using up all of the gas that you send causes your transaction to fail.
    // State changes are undone.
    // Gas spent are not refunded.
    function forever() public {
        // Here we run a loop until all of the gas are spent
        // and the transaction fails
        while (true) {
            i += 1;
        }
    }
}

// 10.3 TRANSACTIONS | SENDING EHTER
contract ReceiveEther {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

// ASSIGNMENT
// Build a charity contract that receives Ether that can be withdrawn by a beneficiary.
// 1.Create a contract called Charity.
// 2.Add a public state variable called owner of the type address.
// 3.Create a donate function that is public and payable without any parameters or function code.
// 4.Create a withdraw function that is public and sends the total balance of the contract to the owner address.
contract Charity {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function donate() public payable {}

    function withdraw() public {
        uint256 amount = address(this).balance;
        (bool sent, bytes memory data) = owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
