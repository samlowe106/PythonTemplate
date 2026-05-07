import argparse

from dotenv import load_dotenv

# load environment variables from .env file
# (this is where you put your secret keys and other configuration settings)
load_dotenv()


def main(args):
    pass


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="My Python App")
    # parser.add_argument()
    args = parser.parse_args()

    main(args)
