1.To connect to EC2 we need to create the public and private key
2.For creating public and private key on windows we need to install the putty 
4.Install a feature OpenSSH Client from  windows setting app features.
 https://phoenixnap.com/kb/generate-ssh-key-windows-10
3.After installing please open CMD and run this command
    ssh-keygen -t rsa -b 2048 
4.Make sure that username should macth the ami for EC2.Else access denied error will come
    example user Ubuntu then ami should be of ubuntu 

    