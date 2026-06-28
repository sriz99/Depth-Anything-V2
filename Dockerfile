# Use NVIDIA CUDA base image with Python 3.10  
# FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04  
# FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04  
FROM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu22.04
  
# Set environment variables  
ENV DEBIAN_FRONTEND=noninteractive  
ENV PYTHONUNBUFFERED=1  
ENV CUDA_VISIBLE_DEVICES=0  
  
# Install system dependencies  
RUN apt-get update && apt-get install -y \  
    python3.10 \  
    python3-pip \  
    python3-dev \  
    git \  
    wget \  
    libgl1-mesa-glx \  
    libglib2.0-0 \  
    libsm6 \  
    libxext6 \  
    libxrender-dev \  
    libgomp1 \  
    && rm -rf /var/lib/apt/lists/*  
  
# Create a working directory  
WORKDIR /app  
  
# Clone the repository  
# RUN git clone https://github.com/sriz99/Depth-Anything-V2.git .  

# Copy all the files to the folder
COPY . .
  
# Install Python dependencies (inferred from code imports)  
# RUN pip3 install --no-cache-dir \  
#     torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121  
RUN pip3 install --no-cache-dir \
    torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/cu128

RUN pip3 install --no-cache-dir \
    opencv-python \  
    numpy \  
    pillow \  
    matplotlib \  
    gradio \  
    gradio-imageslider \  
    open3d \  
    transformers \  
    huggingface-hub  
    
# Create checkpoints directory  
RUN mkdir -p checkpoints  
  
# Set up a volume for checkpoints and data  
VOLUME ["/app/checkpoints", "/app/data"]  
  
# Expose port for Gradio demo  
EXPOSE 7860  
  
# Default command to run the Gradio demo  
CMD ["python3", "app.py"]