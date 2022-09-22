// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DormitoryQuest {
    uint constant DURATION = 3 days;

    struct Student {
        uint id;
        string fullName;
        bool sheetsDone;
        bool roomDone;
        bool booksDone;
        uint regDate;
        uint deadlineDate;
    }

    Student[] public students;

    event SummonsToArmyGiven(string name);
    event StudentEvicted(string name, uint date);
    event StudentAdded(uint id, string name, uint regDate);

    function addStudent(string calldata _name, bool _sheetsDone, bool _roomDone, bool _booksDone) public {
        uint currentId = students.length == 0 ? students.length : students.length - 1;

        Student memory newStudent = Student({
            id: currentId,
            fullName: _name,
            sheetsDone: _sheetsDone,
            roomDone: _roomDone,
            booksDone: _booksDone,
            regDate: block.timestamp,
            deadlineDate: block.timestamp + DURATION
        });

        students.push(newStudent);

        emit StudentAdded(newStudent.id, newStudent.fullName, newStudent.regDate);
    }
    
    function debtsAreDone(uint id) public {
        require(id >= 0, "Incorrect id.");

        Student storage _student = students[id];

        if (_student.sheetsDone == false || _student.roomDone == false || _student.booksDone == false || _student.deadlineDate <= block.timestamp)
        {
            emit SummonsToArmyGiven(_student.fullName);
            return;
        }

        emit StudentEvicted(_student.fullName, block.timestamp);
    }
}