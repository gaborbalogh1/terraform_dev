Created this dev environment for my other repo which is without the dev so 
i can run two workplace in Jenkins and create another job for 
practice.

If you would like to take this further here is an overview 

terraform - main folder
   main.tf - main config file
   variables.tf - reference variable for your deployment
   output.tf - any result you would like to print out after deployment should go here.
 

Other files not commonly used in my config are:

tf.state - sits on the s3 bucket for backend storing state of deployment 

     
