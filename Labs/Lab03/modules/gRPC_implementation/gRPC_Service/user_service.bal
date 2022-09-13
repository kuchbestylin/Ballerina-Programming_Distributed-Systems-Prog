import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_HELLOWORLD, descMap: getDescriptorMapHelloworld()}
service "User" on ep {

    remote function createUser(CreateRequest value) returns CreateResponce|error {
        CreateResponce r = {"userid" : "hello + ${value.firstname}"};
        return r;
    }
}

