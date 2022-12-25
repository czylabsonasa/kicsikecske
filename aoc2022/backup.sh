#!/bin/bash
tar --exclude={"*__*","backup.tgz"} -czf backup.tgz *
