import time
import os
import random
import pandas as pd
from pandas import *
import xlrd
import csv
from robot.api.deco import keyword

@keyword(name='Get All Files With Name Start With')
def get_all_files_with_name_start_with(path: str, filetype: str = None, name: str = None):
    os.chdir(path)
    files = sorted(os.listdir(os.getcwd()), key=os.path.getctime)
    if filetype is not None:
        files = [f for f in files if filetype in f]
    if name is not None:
        files = [f for f in files if name in f]
    print(len(files))
    return files if len(files) > 0 else None


@keyword(name='Clear Files In Path')
def clear_files_in_path(path: str, fileType: str, name: str = None):
    os.chdir(path)
    files = sorted(os.listdir(os.getcwd()), key=os.path.getctime)
    files = [f for f in files if fileType in f]
    if name is not None:
        files = [f for f in files if name in f]
    if len(files) > 0:
        for f in files:
            file_path = os.path.join(path, f)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
            except Exception as e:
                print('Erro ao apagar arquivo %s, Motivo: %s' % (file_path, e))

@keyword(name='Read Rows')
def read_rows(path: str, rows: int=1, row_size:int =5):
  df = pd.read_excel(io=rf'{path}')
  result = list(df.head(rows))
  rm = str(df.head(rows)).replace('NaN', '0', -1)
  linha = list()
  linhas = list()
  temp = ""
  for i in rm:
    if i in '0123456789':
      temp += i
    else:
      if len(temp) > 0:
        linha.append(temp)
        temp = ""
        if len(linha) > row_size:
          linhas.append(linha)
          linha = list()
  linhas.append(linha)
  print(linhas[0] if len(linhas) == 1 else linhas)
  return linhas[0] if len(linhas) == 1 else linhas

@keyword(name='Get All Lines From XLS')
def get_all_lines_from_xls(path: str):
  file = ExcelFile(rf'{path}')
  file = file.parse(file.sheet_names[0])
  result = file.to_dict()
  linhas = list()
  linha = list()

  for i in range(0, len(result[list(result.keys())[0]].keys())):
    for y in range(0, len(list(result.keys()))):
      linha.append(result[list(result.keys())[y]][i])
    linhas.append(linha)
    linha = list()
  print(linhas)
  return linhas

@keyword(name='Wait File Download')
def wait_file_download(path: str, filetype: str = None, name: str = None):
  for i in range(0, 60):
    files = get_all_files_with_name_start_with(path, filetype, name)
    if files is None or len(files) == 0:
      time.sleep(5)
    else:
      return files

@keyword(name='Get Cell Value From XLS')
def get_cell_value_from_xls(path: str, col: int, row:int = -1):
  file = xlrd.open_workbook(rf'{path}')
  sh = file.sheet_by_index(0)
  v = sh.cell_value(rowx=(sh.nrows-1) if row == -1 else (row - 1), colx=col)
  print(v)
  return v


@keyword(name='Read CSV File')
def read_csv_file(filename):
    '''This creates a keyword named "Read CSV File"

    This keyword takes one argument, which is a path to a .csv file. It
    returns a list of rows, with each row being a list of the data in
    each column.
    '''
    data = []
    with open(filename,) as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            data.append(row)
    return data
