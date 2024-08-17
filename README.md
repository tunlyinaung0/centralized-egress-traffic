# centralized-egress-traffic

<img width="767" alt="Centralized Egress Traffic" src="https://github.com/user-attachments/assets/bf80d664-12a0-45a9-9cf7-11f7043f264a">



## Transit Gateway Route Table

#### Since VPC-A and VPC-B have the same scenario, they can share the same TGW Route Table.

```http
  TGW Route Table for VPC-A and VPC-B
```

|    Destination     |     Target     | 
|    :--------       |    :-------    | 
|    `0.0.0.0/0`     | `Attachment-C` | 



##
```http
  TGW Route Table for VPC-C
```

|    Destination     |     Target       | 
|    :--------       |    :-------      | 
|    `10.0.0.0/16`   |   `Attachment-A` | 
|    `10.1.0.0/16`   |   `Attachment-B` |



## VPC Route Tables

```http
  Add routes in Private Route Table - A and B
```

|    Destination     |     Target          | 
|    :--------       |    :-------         | 
|    `0.0.0.0/0`     |   `Transit Gateway` | 


##
```http
  Routes for Private Route Table - C
```

|    Destination     |     Target          | 
|    :--------       |    :-------         | 
|    `0.0.0.0/0`     |    `NAT Gateway`    | 
|    `10.0.0.0/16`   |    `Transit Gateway`| 
|    `10.1.0.0/16`   |    `Transit Gateway`| 



##
```http
  Routes for Public Route Table - C
```

|    Destination     |     Target            | 
|    :--------       |    :-------           | 
|    `0.0.0.0/0`     |    `Internet Gateway` | 
|    `10.0.0.0/16`   |    `Transit Gateway`  | 
|    `10.1.0.0/16`   |    `Transit Gateway`  | 
