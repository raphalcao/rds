# FIAP RDS - Automação com Terraform

Este repositório tem como objetivo automatizar a infraestrutura do desafio de integração com o AWS RDS usando Terraform, juntamente com uma CI/CD pipeline via GitHub Actions.

### Nota: 
Para melhor uso, é recomendado o terminal do linux. No Windows, use o wsl.

### Passo a Passo para Utilização do Repositório

### 1. Fazer um Fork
Primeiro, faça um fork deste repositório para sua conta do GitHub.

### 1.1 Criar ou alterar as credenciais AWS.

Execute o comando: `nano ~/.aws/config`
Apague as credenciais 
Cole as novas credencias e salve o arquivo (CTRL + X, aperte Y e depois ENTER).

### 1.1.2 Criar ou alterar as credenciais AWS.

Execute o comando: `nano ~/.aws/credentials`
Apague as credenciais 
Cole as novas credencias e salve o arquivo (CTRL + X, aperte Y e depois ENTER).

### 2.Autenticar o login e password

### 2.1 Entre no arquivo terraform.tfvars
    Pegue as credenciais e cole nos respectivos lugares
 
 Em vpc_id coloque a sua vpc da AWS. Caso não saiba, digite o comando:  
        aws ec2 describe-vpcs --region us-east-1 --query "Vpcs[*].VpcId"
 
 O comando irá retornar conforme o exemplo: 
 [
    "vpc-08622ed23697cddcd"
 ]

 Em Subnet, coloque a subnet criada na AWS. Caso não saiba, digite o comando: 
        aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-08622ed23697cddcd" --query "Subnets[*].SubnetId" --region us-east-1

O comando irá retornar conforme o exemplo:
[
    "subnet-0f59f2c98ae7ef46c",
    "subnet-00b14c04fdd4fabef",
    "subnet-0e5fe36671671eb0e",
    "subnet-00c2f12571807d6c4",
    "subnet-0814e78f75045a3ad",
    "subnet-04a46c8aaf63647cb"
]