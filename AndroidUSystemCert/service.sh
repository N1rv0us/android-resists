#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

mkdir -p -m 700 $MODDIR/tmp-ca-copy
cp /apex/com.android.conscrypt/cacerts/* $MODDIR/tmp-ca-copy/
mount -t tmpfs tmpfs /system/etc/security/cacerts
cp $MODDIR/tmp-ca-copy/* /system/etc/security/cacerts/
cp /data/local/tmp/cacerts/* /system/etc/security/cacerts/

chown root:root /system/etc/security/cacerts/*
chmod 644 /system/etc/security/cacerts/*
chcon u:object_r:system_file:s0 /system/etc/security/cacerts/*

echo "prepare to inject" >> $MODDIR/log.txt
sleep 10
echo "stop waiting ..." >> $MODDIR/log.txt

ZYGOTE_PID=$(pidof zygote || true)
ZYGOTE64_PID=$(pidof zygote64 || true)

echo "$ZYGOTE_PID" >> $MODDIR/log.txt
echo "$ZYGOTE64_PID" >> $MODDIR/log.txt

for Z_PID in "$ZYGOTE_PID" "$ZYGOTE64_PID"; do
    if [ -n "$Z_PID" ]; then
        nsenter --mount=/proc/$Z_PID/ns/mnt -- /bin/mount --bind /system/etc/security/cacerts /apex/com.android.conscrypt/cacerts
        # echo "debug" >> $MODDIR/log.txt
    fi
done

echo "injected zygote process done." >> $MODDIR/log.txt

APP_PIDS=$(
    echo "$ZYGOTE_PID $ZYGOTE64_PID" | \
    xargs -n1 ps -o 'PID' -P | \
    grep -v PID
)

for PID in $APP_PIDS; do
    nsenter --mount=/proc/$PID/ns/mnt -- /bin/mount --bind /system/etc/security/cacerts /apex/com.android.conscrypt/cacerts &
done

echo "System certificate injected" >> $MODDIR/log.txt

# This script will be executed in late_start service mode
# More info in the main Magisk thread
