# Import System Certs for Android U

Android 14 adjusted the read policy of system certificates, so that the traditional remount /system/etc/security/cacerts/ cannot import system certificates effectively.

This Magisk module references the new strategy mentioned in the httptoolskits blog to help users more easily import system certificates on Android 14.



## How to use

### Installation

1. Install Magisk in your device.

2. clone this project and zip it. `zip -r TrustMeU.zip ./*`

3. Install this module in Magisk APP. and reboot your device



### Adding a new certificate

1. Make your own certificate(like xxxxxx.0)

2. Upload your certificates to your device directory `/data/local/tmp/cacerts`

3. Keep this module in Magisk APP

4. Reboot your device



### Use this module without Magisk

1. Upload `service.sh` to an executable directory.

2. Adjusting the path pointed to by `$MODDIR` in scripts

3. Run `service.sh`



## Change Log

* 0.0.1 : first publish



## Credits

* https://github.com/httptoolkit/httptoolkit-android
