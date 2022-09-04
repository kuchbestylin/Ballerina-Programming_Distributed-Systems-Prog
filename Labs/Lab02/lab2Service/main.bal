// import ballerina/io;

User[] userss = [
    {firstname: "John", lastname: "Doe", username: "Jdoe", email: "Jdoe@gmail.com"},
    {firstname: "James", lastname: "Lemar", username: "Jlemar", email: "Jlemar@gmail.com"},
    {firstname: "Kelly", lastname: "Thompson", username: "KThompson", email: "Kthompson@gmail.com"}
    ];
    string username = "KThompson";

// public function main() {
//     io:println(userss);
//     User[] filter = userss.filter(cc);
// }
// var cc = function(string username) returns boolean {
//     foreach var item in userss {
//         if item.username != username {
//             return true;
//         }
//         else {
//             return false;
//         }
//     }
// }