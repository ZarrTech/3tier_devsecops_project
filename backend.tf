terraform {
  cloud { 
    
    organization = "zarrAI" 

    workspaces { 
      name = "SRE" 
    } 
  } 
}