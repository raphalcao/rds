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

### Caso dê erro de autenticação, vá no terminal da aws e faça: 
    1. `rm -rf ~/.aws`
       `mkdir -p ~/.aws`

    2. Cole diretamente no terminal
        [default]
        aws_access_key_id={Key_id}
        aws_secret_access_key={access_key}
        aws_session_token={session_token}
        EOF

        Exemplo: 
        cat <<EOF > ~/.aws/credentials
        [default]
        aws_access_key_id=ASIAUCFCVMMXMC6HNZIB
        aws_secret_access_key=kiABWiG1QQTSVflU+hbmmWgrSGtB3r8MI0XwDukv
        aws_session_token=IQoJb3JpZ2luX2VjELz//////////wEaCXVzLXdlc3QtMiJHMEUCIBhoUpGGTE5hUBuwvPo5difZtUDZBAahd+HnAlNBppCEAiEAswqv      +viJv4RpT6Y4Hl13L71a1imqbeXwHadpheKUPsIqtgII1f//////////ARABGgwyNzk1MTQwMTQ1MTAiDOe5VYmx5ch8k3s+uSqKAi7XOTUVYQOWfi/vRYJuaQgkU1sBbwQETfkBerMRsBDB/   EMrP5DwxiucfRQPd5OGBCMw3Yj/S9WxBOTkyFvWSGR9NO4EnIf/   ONWJSxedBTbkzZ11sfiuB4vt22pWWILKPQs37W6jBU7nqHbOBbH6ghuUlu9SCp2DCTVGhLsAdXNPAfmxpLPIniyOlQhvR2rOYIDInDgLithu91Wjvm6jbimzUFKqzibot6M3T3C5BJ0sNpzADKuUZrlntxw4utio/    xlMySUt11FP3nG2PV5JI99STY4BieZQi7Q8zlE1IRrqNYfBoM03yfAVZoTrx08R0IdhYUUDqM9wVlh2phrxu5wg5G5qAHvqVaeuMOHsrL0GOp0BjFuISapIe7/nNXnu608VtK4Lk   +gntx2JZIQB6g8Auw9xmhOZqbmTvYuHk2ZKa72xPyecnwoJPxkC26kOSGfGjUgyvWFx0yZwQbzpmd7oUvmSpHuOU3685QQ0Hx2XBMVTuf6YmtKrFAO1HrdXNAoGFdg7ONqLrKmBTlTPDPZSdztFGYZj3Qlo2rz5ZGO    Gk3Hit6dZxKyxga8fcLYJfA==
        EOF
