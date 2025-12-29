FROM --platform=linux/x86_64 public.ecr.aws/lambda/python:3.14

# Copy function code
COPY main.py ${LAMBDA_TASK_ROOT}
COPY ansible.cfg ${LAMBDA_TASK_ROOT}
COPY main.yml ${LAMBDA_TASK_ROOT}

# Install the function's dependencies using file requirements.txt
# from your project folder.
COPY requirements.txt  .

RUN pip3 install -r requirements.txt

CMD [ "main.lambda_handler" ]
