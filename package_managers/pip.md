# Pip CLI commands

- `pip list`
- `python -m pip install --upgrade pip`

## Virtual Environments

**Create** env

```bash
python -m venv venv
```

**Activate/Deactivate** env

```bash
.\venv\Scripts\activate
.\venv\Scripts\deactivate
```

## Packages

Either global or in Virtual Environment.

**Install** packages (venv or global)

```bash
pip install --upgrade -r ./environment/requirements.txt

python -m pip install -r ./environment/requirements.txt
```

**Export**  all installed packages  (freeze current state)

```bash
pip freeze > pip_list.txt  
```

**Upgrade** installed packages

```bash
pip install --upgrade --force-reinstall -r requirements.txt
```

**Uninstall** all packages (venv or global)

```bash
pip uninstall -r .\pip_list.txt  -y all
```

## requirements.txt

- [pip docu](https://pip.pypa.io/en/stable/reference/requirements-file-format/)

```bash
dash
dash_bootstrap_components
autopep8
pandas
```
