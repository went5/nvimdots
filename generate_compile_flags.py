import os
import argparse

HEADER_EXTENSIONS = ['.h', '.hpp', '.hh']

def contains_header(directory):
    for dirpath, _, filenames in os.walk(directory):
        if any(filename.endswith(ext) for ext in HEADER_EXTENSIONS for filename in filenames):
            return True
    return False

def generate_include_paths(directories, output_file):
    with open(output_file, 'w') as f:
        for root_dir in directories:
            for dirpath, _, _ in os.walk(root_dir):
                if contains_header(dirpath):
                    # パスを正規化して / を使用する
                    normalized_path = dirpath.replace(os.sep, '/')
                    f.write(f"-I{normalized_path}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate compile_flags.txt with recursive include paths.')
    parser.add_argument('directories', type=str, nargs='+', help='Root directories to start searching for include directories.')
    parser.add_argument('-o', '--output', type=str, default="compile_flags.txt", help='Output file name.')

    args = parser.parse_args()
    generate_include_paths(args.directories, args.output)
