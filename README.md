# ICBC Appointment Checker

This script checks for available road test appointments at various ICBC locations and sends email notifications if there are any changes.

## Features

- Checks for available road test appointments at specified ICBC locations.
- Sends email notifications if there are any changes in the available appointments.
- Saves the latest appointments to a text file.

## iOS Shortcut Solution

![iOS shortcuts logo](./resources/iOS_shortcuts_logo.png)

This script is now available as an iOS Shortcut, which allows you to download the script to your iOS device with 1-click and set up notifications alerts for when an appointment is available.

### Steps

1. Download the [Scriptable App from the App Store](https://apps.apple.com/us/app/scriptable/id1405459188)
1. Download the [iOS Shortcut from this link](https://www.icloud.com/shortcuts/6a3b5ec64fcd4ffe87076f6062add689)
1. Go to the Shortcuts app
    1. Click on `Shortcuts`, click on this shortcut, and enter your details.
    1. Click on `Automation`, add a new automation.
        1. Click `Time of Day`
        1. Click `Run Immediately`
        1. Turn off `Notify When Run`
        1. Select the `ICBC Drivers Test Appointment` shortcut

Done! Now you will get a notification when the next appointment becomes available.

## Requirements

- Python 3.x
- `requests`
- `pyyaml`
- `loguru`
- `faker`

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/zjuguxi/icbc-appointment-checker.git
    cd icbc-appointment-checker
    ```

2. Install the required Python libraries:

    ```bash
    pip install requests pyyaml loguru faker
    ```

## Configuration

1. Create a `config.yml` file in the project directory. You can use the provided `config.yml.example` as a template:

    ```bash
    cp config.yml.example config.yml
    ```

2. Edit the `config.yml` file with your own details:

    ```yaml
    icbc:
      drvrLastName: "YourLastName"
      licenceNumber: "YourLicenceNumber"
      keyword: "YourKeyword"
      expactAfterDate: "2024-05-01"
      expactBeforeDate: "2024-06-01"
      expactAfterTime: "08:00"
      expactBeforeTime: "17:00"
      examClass: "5"
      posID: 273
      prfDaysOfWeek: "[0,1,2,3,4,5,6]"
      prfPartsOfDay: "[0,1]"

    email:
      smtp_server: "smtp.your-email-provider.com"
      smtp_port: 587
      sender_address: "your_email@provider.com"
      sender_pass: "your_application_specific_password"
      receiver_addresses:
        - "receiver1_email@provider.com"
        - "receiver2_email@provider.com"
    ```

## Usage

Run the script with the specified config file:

```bash
python icbc_appointment_checker.py config.yml
```

For continuous checking, you can use the `--interval` flag:

```bash
python icbc_appointment_checker.py config.yml --interval 3600
```

This will check every 3600 seconds (1 hour).

## Docker Setup

You can run the ICBC appointment checyker continuously in Docker:

1. Create your `config.yml` file from the example:

   ```bash
   cp config.yml.example config.yml
   ```

2. Edit the `config.yml` file with your details

3. Build and run with Docker Compose:

   ```bash
   docker-compose up -d
   ```

   This will run the checker in the background and automatically restart if it crashes.

4. Check the logs:

   ```bash
   docker-compose logs -f
   ```

5. To stop the checker:

   ```bash
   docker-compose down
   ```

You can adjust the check interval by modifying the `CHECK_INTERVAL` environment variable in the `docker-compose.yml` file.

## Scheduling with Crontab

To schedule the script to run at regular intervals, you can use `crontab`. Here's how to set it up:

1. Open the crontab editor:

    ```bash
    crontab -e
    ```

2. Add a new line to schedule the script. For example, to run the script every hour, add:

    ```bash
    0 * * * * /usr/bin/python3 /path/to/icbc_appointment_checker.py /path/to/config.yml
    ```

    Replace `/usr/bin/python3` with the path to your Python 3 executable, and `/path/to/icbc_appointment_checker.py` and `/path/to/config.yml` with the correct paths to the script and configuration file.

3. Save and exit the editor.

The script will now run every hour and check for available ICBC appointments and send email notifications to the specified recipients if there are any changes.

## Location Parameters

| Location                                         | posID |
|--------------------------------------------------|-------|
| Richmond claim centre (Elmbridge Way)            | 273   |
| Richmond driver licensing (Lansdowne Centre mall)| 93    |
| Vancouver driver licensing (Point Grey)          | 9     |
| Vancouver claim centre (Kingsway)                | 275   |
| Burnaby claim centre (Wayburne Drive)            | 274   |
| Surrey driver licensing                          | 11    |
| Newton claim centre (68 Avenue)                  | 271   |
| Surrey claim centre (152A St.)                   | 269   |
| North Vancouver driver licensing                 | 8     |


## Changelog
See the full changelog in [CHANGELOG.md](./CHANGELOG.md).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
