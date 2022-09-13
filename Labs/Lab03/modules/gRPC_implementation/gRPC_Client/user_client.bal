import ballerina/io;
UserClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    CreateRequest cr = {"username":"JSmith","firstname":"John","lastname":"Smith","email":"jdoe@gmail.com"};
    CreateResponce uc = check ep -> createUser(cr);
    io:println(uc.userid);
}

