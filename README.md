# Centralized Egress Traffic

![Centralized Egress Traffic](https://github.com/user-attachments/assets/419342e9-615d-4aa2-baef-a6fe2486465d)



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
