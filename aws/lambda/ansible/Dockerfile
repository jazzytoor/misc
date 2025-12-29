FROM public.ecr.aws/lambda/python:3.8

# Copy function code
COPY main.py ${LAMBDA_TASK_ROOT}
COPY ansible.cfg ${LAMBDA_TASK_ROOT}
COPY main.yml ${LAMBDA_TASK_ROOT}

# Install the function's dependencies using file requirements.txt
# from your project folder.

COPY requirements.txt  .
RUN pip3 install -r requirements.txt

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "main.handler" ]