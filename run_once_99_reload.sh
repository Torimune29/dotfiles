#!/usr/bin/env bash

chezmoi state delete-bucket --bucket=entryState
chezmoi apply
