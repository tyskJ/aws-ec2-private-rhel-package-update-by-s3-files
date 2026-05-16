#!/bin/bash

# 標準出力(stdout)の出力先を変更
# >(...) はプロセス置換で、コマンドの出力を別プロセスに渡す
# tee:
#  - 出力をファイル(/var/log/userdata.log)に保存しつつ、次のコマンドにも流す
# logger:
#  - syslog に "userdata" というタグ付きでログを送る
#  - -s オプションで標準エラーにも出力
# 2>&1:
#  - 標準エラー(stderr)も標準出力(stdout)と同じ出力先にまとめる
# 2>/dev/console:
#  - logger の標準エラーを EC2 のコンソールログにも出力（トラブルシュート用）
exec > >(tee /var/log/userdata.log | logger -t userdata -s 2>/dev/console) 2>&1



# Shell Options
# e : エラーがあったら直ちにシェルを終了
# u : 未定義変数を使用したときにエラーとする
# o : シェルオプションを有効にする
# pipefail : パイプラインの返り値を最後のエラー終了値にする (エラー終了値がない場合は0を返す)
set -euo pipefail

########################################
# HostName
########################################
hostnamectl set-hostname ${hostname}

########################################
# SSM Agent Install
########################################
cd /tmp
dnf --disablerepo="*" install -y https://s3.${region_name}.amazonaws.com/amazon-ssm-${region_name}/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable --now amazon-ssm-agent