# mogilefs-mogilefsd
mogilefs-mogilefsd is the mogilefs tracker




use this images you need provide mysql database 
         
    create database and create user:
    mysql
    CREATE DATABASE MogileFS DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;  
    grant all on MogileFS.* to 'mogile_name'@'%' identified by 'mogile_password';  
    FLUSH PRIVILEGES;  
    quit   
              
Before you start your mogilefsd server，you need Initialization your mysql database;
 
    docker run --rm -u root kcrist/mogilefs-mogilefsd:latest mogdbsetup --dbhost=MYSQL_IP --dbname=DBNAME --dbuser=MOGILE_USERNAME --dbpass=MOGILE_PASSWORD --dbrootpass=ROOT_PASSWORD --dbrootuser=ROOT_USERNAME --yes

now,you need provide config file：

    cat /etc/mogilefs/mogilefsd.conf
    # Database connection information  
    db_dsn = DBI:mysql:MogileFS:host=mogiledb.yourdomain.com  
    db_user = mogile  
    db_pass = mogilepw  

    # IP:PORT to listen on for MogileFS client requests  
    listen = 127.0.0.1:7001  

    # Optional, if you don't define the port above.  
    conf_port = 7001  

    # Number of query workers to start by default.  
    query_jobs = 5  

    # Number of delete workers to start by default.  
    delete_jobs = 1  

    # Number of replicate workers to start by default.  
    replicate_jobs = 2  

    # Number of reaper workers to start by default.  
    # (you don't usually need to increase this)  
    reaper_jobs = 1  

last， you can run the tracker server now:
  
    docker run -d -p 7001:7001 -v ./mogilefsd.conf:/etc/mogilefs/mogilefsd.conf kcrist/mogilefs-mogilefsd:latest
    
set /etc/mogilefs/mogilefs.conf
  
    trackers = TRACKER_IP:PORT
    
after your mogstore start up you can use the following commands:
    
    #add host:
      mogadm host add <storage_node_name> --ip=127.0.0.1 --port=7500 --status=alive 
    #display host:
      mogadm host list 
    #add device: 
      mogadm  device add <storage_node_name> ID 
    #display device:
      mogadm  device list
    #add domain:
      mogadm domain add <domain_name>
    #display domain:
      mogadm  domain list
    #add class:
      mogadm  class add <domain_name> <class_name> --mindevcount=3
    #display class:
      mogadm class list
    #check mogilefs system:
      mogadm check
    #upload file
      mogupload  --domain=foo --key=<key_name> --file=<file_path>
    #query file
      mogfileinfo --trackers=host --domain=<domain_name> --key=<key_name>
    #check file status
      mogfiledebug --domain=he.yinyuetai.com --key=crossdomain
    #delete file
      mogdelete  --domain=<domain_name> --key=<key_name>
    #list keys
      moglistkeys  --domain=<domain_name> --key_prefix=<key_name>
    #list fid file
      moglistfids  --fromfid=<file_id> --count=<number>
