from __future__ import print_function, division
import argparse
import sys
import os

REGIONS = ['ea', 'eus', 'neu', 'scu', 'sea', 'wcu']
MODES = ['spoke', 'hub-spoke', 'spoke-uc', 'hub-spoke-uc']
ACTIONS = ['plan', 'apply', 'destroy']
ENVIRONMENT = ['dev', 'stage', 'prod', 'test']

def deploy(region: str, mode: str, action: str, env: str):
	if not isinstance(region, str):
		raise TypeError("Invliad region arg type: Expected str, got {}".format(type(region).__name__))
	region = region.lower()
	if not region in REGIONS:
		raise UserWarning("Region arg ({}) must be in {}".format(region, REGIONS))
	if not isinstance(region, str):
		raise TypeError("Invliad mode arg type: Expected str, got {}".format(type(mode).__name__))
	mode = mode.lower()
	if not mode in MODES:
		raise UserWarning("Mode arg ({}) must be in {}".format(mode, MODES))
	if not isinstance(action, str):
		raise TypeError("Invliad action arg type: Expected str, got {}".format(type(action).__name__))
	action = action.lower()
	if not action in ACTIONS:
		raise UserWarning("Action arg ({}) must be in {}".format(action, ACTIONS))
	env = env.lower()
	if not env in ENVIRONMENT:
		raise UserWarning("Action arg ({}) must be in {}".format(env, ENVIRONMENT))

	root = os.path.dirname(os.path.abspath(__file__))
	if mode == "spoke":
		new_cwd = os.path.join(os.path.join(root, "spoke"), "spoke-infra")
	elif mode == "hub-spoke":
		new_cwd = os.path.join(os.path.join(root, "hub-spoke"), "hub-spoke-infra")
	elif mode == "spoke-uc":
		new_cwd = os.path.join(os.path.join(root, "spoke"), "spoke-unity")
	elif mode == "hub-spoke-uc":
		new_cwd = os.path.join(os.path.join(root, "hub-spoke"), "hub-spoke-unity")
    
    if mode in ['spoke', 'hub-spoke']:
    	var_file = os.path.join(root, "config/infra/{}/regions/{}/{}.data.tfvars".format(env, region, region))
    else:
    	var_file = os.path.join(root, "config/unity/{}/regions/{}/{}.data.tfvars".format(env, region, region))


	if mode == "plan":
		print('(cd {} && terraform plan -var-file="{}" -out="plan.out")'.format(new_cwd, var_file))
	elif mode == "apply":
		print('(cd {} && terraform apply -var-file="{}" "plan.out")'.format(new_cwd, var_file))
	elif mode == "destroy":
		print('(cd {} && terraform destroy -var-file="{}")'.format(new_cwd, var_file))


if __name__ == "__main__":
	parser = argparse.ArgumentParser(description='Description of your program')
	parser.add_argument('-r','--region', help="Region name: ['ea', 'eus', 'neu', 'scu', 'sea', 'wcu']", required=True)
	parser.add_argument('-m','--mode', help="Mode: ['spoke', 'hub-spoke', 'spoke-uc', 'hub-spoke-uc']" , required=True)
	parser.add_argument('-a','--action', help="Terraform action: ['plan', 'apply', 'destroy']" , required=True)
	parser.add_argument('-e','--env', help="Environment: ['dev', 'stage', 'prod', 'test']" , required=True)
	args = parser.parse_args()
    deploy(region=args.region, mode=args.mode, action=args.action, env=args.env)



