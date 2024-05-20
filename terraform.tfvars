cidr="10.0.0.0/16"
machine_type="t2.micro"
region="us-east-1"
key_name= "key4"
machine_details={
    name="bastion",
    type="t2.micro",
    ami="ami144238737",
    public_ip=true
}

subnets=[

{
    name="public1",
    cidr="12.0.1.0/24",
    type="public",
    availability_zone = "a"
},

{
    name="private1",
    cidr="12.0.2.0/24",
    type="private",
    availability_zone = "a"
},

{
    name="private2",
    cidr="12.0.3.0/24",
    type="private",
    availability_zone = "b"

}
]



create_key_file=true