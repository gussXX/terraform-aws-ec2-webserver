<h1 align="center">Provisionamento de uma VM simples na AWS (EC2) 👾</h1>

### Objetivos

- Criar uma instância EC2 com Ubuntu.
- Configurar security group para permitir SSH e HTTP.
- Output do IP público da VM.
<br>

### Diagrama do Projeto
  
  <p align="center">
      <img align="center" src="./imgs/diagrama-v1.png" height="auto" width="auto" />
  </p>

<br/>

### 🧰 Tecnologias e Ferramentas

- [Terraform](https://www.terraform.io/) `v1.x`
- [AWS CLI](https://aws.amazon.com/cli/)
- Conta na [AWS](https://aws.amazon.com/)
- Provedor `hashicorp/aws`

<br/>

### 🛠️ Estrutura dos Recursos

- **EC2 Instance**: Ubuntu Server
- **Security Group**:
  - Ingress para:
    - Porta 22: Acesso SSH via IP específico
    - Porta 80: Acesso HTTP para toda internet
  - Egress para:
    - Tráfego TCP saindo para `10.0.0.0/8` (faixa interna)
- **User Data Script**: script de inicialização (opcional)
- **Output**: IP público da EC2

<br/>

### Passos iniciais

Devemos iniciar o projeto como o comando:

    terraform init
