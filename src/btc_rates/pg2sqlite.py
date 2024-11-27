#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# pg2sqlite.py - Wednesday, November 13, 2024
""" Copy Date Dimension from PostgreSQL to SQLite """
__version__ = "0.1.0-dev11"

import os
import sqlite3 as lite
import sys
import time
from datetime import datetime, timedelta
from glob import glob
from os.path import exists, getmtime, join, lexists, realpath
from pathlib import Path

import pandas as pd
import sqlalchemy as sa

__module__ = Path(__file__).resolve().stem
_basedir = Path(__file__).resolve().parent
_replace_db = False

def main():
	export()
	return


def init():
	started = time.strftime(_iso_datefmt, _run_localtime)
	print(f"Run Start: {__module__} v{__version__} {started}")
	return


def eoj():
	stop_ts = time.time()
	stop_localtime = time.localtime(stop_ts)
	stop_gmtime = time.gmtime(stop_ts)
	duration = timedelta(seconds=(stop_ts - _run_ts))
	print(f"Run Stop : {time.strftime(_iso_datefmt, stop_localtime)}  Duration: {duration}")
	return


def do_nothing():
	pass


def export():
	src_tbl_name = "dim_date"
	dst_tbl_name = "dim_date"
	csv_filename = f"{src_tbl_name}.csv"
	df = pd.read_sql_table(src_tbl_name, pg_engine, index_col="id")
	# SQLite stores DATE columns as DATETIME, so convert them to TEXT
	date_cols = [
		"date_id",
		"week_from",
		"week_thru",
		"week_from_iso",
		"week_thru_iso",
		"month_from",
		"month_thru",
		"quarter_from",
		"quarter_thru",
		"year_from",
		"year_thru",
	]
	for dc in date_cols:
		df[dc] = df[dc].dt.strftime('%Y-%m-%d')
	if not exists(csv_filename) or _replace_db:
		df.to_csv(csv_filename, index=False)
	if not exists(dst_db_name) or _replace_db:
		df.head(10)
		df.to_sql(dst_tbl_name, lite_engine, if_exists="replace", index=True)
	return


if __name__ == '__main__':
	_run_ts = time.time()
	_run_dt = datetime.fromtimestamp(_run_ts).astimezone()
	_run_localtime = time.localtime(_run_ts)
	_run_gmtime = time.gmtime(_run_ts)
	_run_ymd = time.strftime("%Y%m%d", _run_localtime)
	_run_hms = time.strftime("%H%M%S", _run_localtime)
	_run_ymdhms = f"{_run_ymd}_{_run_hms}"
	_iso_datefmt = "%Y-%m-%d %H:%M:%S%z"

	# Database
	pg_engine = sa.create_engine("postgresql://localhost/developmentdb")
	dst_db_name = "dim_date.db"
	lite_engine = sa.create_engine(f"sqlite:///{dst_db_name}")

	# with pg_engine.connect() as tran:
	# 	result = tran.execute(sa.text("SELECT count(*) FROM dim_date;"))
	# 	print(result.rowcount)
	# 	print(result.fetchone())

	init()
	main()
	eoj()
