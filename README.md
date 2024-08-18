# Centralized Egress Traffic

![Centralized Egress Traffic](https://github.com/user-attachments/assets/419342e9-615d-4aa2-baef-a6fe2486465d)




## Components to be created in this scenario

- VPC-A with CIDR 10.0.0.0/16
- VPC-B with CIDR 10.1.0.0/16
- VPC-C with CIDR 10.2.0.0/16
- 1 Private Subnet and Private Route table for VPC-A
- 1 Private Subnet and Private Route table for VPC-B
- 1 Private Subnet, 1 Public Subnet, Public Route Table and Private Route table for VPC-C
- Internet Gateway and NAT Gateway for VPC-C
- Transit Gateway
- 2 Transit Gateway Route Tables ( one for VPC-A and B , another for VPC-C )
- 3 Transit Gateway Attachments ( For VPC-A,B and C)
- 2 ec2 instances to be created in private subnets of VPC-A and VPC-B with no internet access. 



## Transit Gateway Route Table

#### Note: Since VPC-A and VPC-B have the same scenario, they can share the same TGW Route Table.


####  TGW Route Table for VPC-A and VPC-B


|    Destination     |     Target     | 
|    :--------       |    :-------    | 
|    `0.0.0.0/0`     | `Attachment-C` | 



##

####  TGW Route Table for VPC-C


|    Destination     |     Target       | 
|    :--------       |    :-------      | 
|    `10.0.0.0/16`   |   `Attachment-A` | 
|    `10.1.0.0/16`   |   `Attachment-B` |



## VPC Route Tables


####  Add routes in Private Route Table - A and B


|    Destination     |     Target          | 
|    :--------       |    :-------         | 
|    `0.0.0.0/0`     |   `Transit Gateway` | 


##

####  Routes for Private Route Table - C


|    Destination     |     Target          | 
|    :--------       |    :-------         | 
|    `0.0.0.0/0`     |    `NAT Gateway`    | 
|    `10.0.0.0/16`   |    `Transit Gateway`| 
|    `10.1.0.0/16`   |    `Transit Gateway`| 



##

####  Routes for Public Route Table - C


|    Destination     |     Target            | 
|    :--------       |    :-------           | 
|    `0.0.0.0/0`     |    `Internet Gateway` | 
|    `10.0.0.0/16`   |    `Transit Gateway`  | 
|    `10.1.0.0/16`   |    `Transit Gateway`  | 
