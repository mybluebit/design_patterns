// Design Patterns for Blockchain - Winter 2022
// Assignment Lab-01
// Ahmad Mahroo - 101086818



pragma solidity ^0.4.18;


contract design_Patt_Lab_01 {

    // Setting variable ـOwnerـ to the contract deployer address
    
    address owner;
    constructor() public {
      owner = msg.sender;
    }

    // Creating a modifier
	modifier justOwner {
        require(msg.sender == owner, 'You are not the contract Owner!');
        _;
    }
    

    // Creating a new modifier for student's mark 0 to 100
	modifier validateMark (uint8 studenMark) {
        require(studenMark>=0 && studenMark<=100 , 'Student mark has to be ranged 0 and 100');
        _;
    }
    
    
    // Stuct = student info

    struct Student {
        string name;
        string subject;
        uint8 mark;
    }
    
    event StudentAdded(
       string content
    );

   
   // Mapping begins here

    mapping(address => Student) students;

    
    uint mapSize;
    
 
    function adding_values(address _address, string memory _name, string memory _subject, uint8 _mark) public validateMark(_mark) {
        
        Student storage student = students[_address];
        student.name = _name;
        student.subject = _subject;
        student.mark = _mark;
 
        mapSize++;
        
        emit StudentAdded("Student has been added successfully");
    }
    
    
    
    function get_std_info(address _address) view public justOwner returns (string memory, string memory, uint8) {
        string memory _name = students[_address].name;
        string memory _subject = students[_address].subject;
        uint8 _mark = students[_address].mark;
        return (_name, _subject, _mark);
    }
        
 


 
    function counting_student() view public returns (uint) {
        return mapSize;
    }
}