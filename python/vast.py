from pathlib import Path

default_dir = "files"

def get_meta_data(file_name):
    """read a .vast file and return metadata as a dictionary"""
    file_path = Path(file_name + ".vast")

    if not file_path.is_file():
        raise FileNotFoundError(f"{file_name} does not exist")
    if file_path.suffix != ".vast":
        raise ValueError("File must be .vast")
    
    meta_data = {}
    with file_path.open() as f:
        for line in f:
            line = line.strip()
            if not line or "=" not in line:
                continue

            key, value = line.split("=", 1)
            key = key.strip()
            value = value.strip().strip('/"')

            if "," in value:
                value = [item.strip() for item in value.split(",") if item.strip()]

            meta_data[key] = value

    return meta_data

def create_vast_from_template(template: str, dir = default_dir):
    pass