import torch  
# Clear CUDA cache before processing each image  
if torch.cuda.is_available():  
    torch.cuda.empty_cache()  
    torch.cuda.synchronize()