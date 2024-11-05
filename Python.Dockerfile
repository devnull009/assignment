FROM python:3.13.0-bookworm@sha256:feee4734fdc44cc09a3c9cdb72e05bb8ff7e964f64766bc1a68638b2c667cf35

# Set working directory
WORKDIR /usr/src/app

# Transfer requirements and the Jenkins automation files
COPY scripts/python/requirements.txt ./
COPY scripts/python/create_job.py ./
RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python", "./create_job.py" ]
