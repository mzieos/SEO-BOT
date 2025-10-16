# SEO Bot - Web Traffic Simulator v1.2

A sophisticated Python-based web traffic bot that simulates human-like browsing behavior to visit websites with natural interactions.

## 📁 Project Structure

```
SEO_BOT/
├── runBot.bat                                  # Perfect launcher
├── Source/
│   ├── __pycache__/                            # Cache
│   ├── SEO_BOT.py                              # Updated for multi-bot
│   └── bot_manager.py                          # Unlimited scaling
├── Customize/
│   ├── urls.txt
│   ├── spend_time.txt
│   └── bot_count.txt                           # Your bot count (49, 100, 1000, etc.)
└── Logs/
    ├── bot_1/                                  # Individual bot logs
    ├── bot_2/
    └── ... (as many as bot_count.txt)
```

## 🚀 Quick Start

### Method 1: Automated Setup (Recommended)

1. **Double-click** `runBot.bat`
2. The script will automatically:
   - Install Python if missing
   - Install all required dependencies
   - Verify your configuration
   - Launch the traffic bot

### Method 2: Manual Setup

If you prefer manual installation:

1. **Install Python 3.11+** from [python.org](https://python.org)
2. **Install requirements**:

   ```bash
   pip install -r source/requirements.txt
   ```

3. **Run the bot**:

   ```bash
   python source/SEO_BOT.py
   ```

## ⚙️ Configuration

I'll update the bot count section of your documentation. Here's the revised configuration section:

## ⚙️ Configuration

### 1. BOT Count (`Customize/bot_count.txt`)

**System Requirements Guide:**

##### Specify the number of concurrent bots to run

```
10    # Safe test          (~2GB RAM, 4-core CPU)
50    # Balanced scale     (~10GB RAM, 6-core CPU) 
100   # Medium scale       (~20GB RAM, 8-core CPU)  
500   # Large scale        (~100GB RAM, 16-core CPU)
1000  # Extreme scale      (Server-grade hardware)
5000  # INSANE scale! 🚀
```

**Performance Optimizations:**

- Smart Concurrency: Higher concurrency limits for more bots
- Reduced Console Spam: Only shows first 50 bots in console
- Progress Tracking: For 50+ bots, shows progress every 10 completions
- Memory Warnings: Automatic RAM usage estimates
- Safety Confirmation: Asks for confirmation for 1000+ bots

### 2. Visit Duration (`Customize/spend_time.txt`)

Specify time in seconds (60 seconds to 24 hours):

```
600 seconds
```

This means 10 minutes (600 seconds) per URL.

### 3. URLs Configuration (`Customize/urls.txt`)

Add your target URLs, one per line:

```
https://www.example.com/
https://www.anotherexample.com/
https://www.yoursite.com/
```

The updated bot count section now includes the scale testing information and system requirements you provided, making it clear what hardware is needed for each bot count level.

## 🎯 Features

### 🤖 Human-Like Behavior

- **Natural browsing patterns** with random delays
- **Realistic mouse movements** and scrolling
- **Smart element clicking** on buttons and links
- **Variable session durations** based on total time

### 🔧 Advanced Capabilities

- **Redirect handling** - Maintains exact URLs
- **Anti-detection** - Random user agents and browser fingerprints
- **Verification detection** - Identifies CAPTCHAs and challenges
- **Comprehensive logging** - Detailed activity tracking

### ⏱️ Smart Time Management

- **Short visits** (1-5 min): Quick interactions
- **Medium visits** (5-30 min): Balanced activities  
- **Long visits** (30+ min): Extended browsing sessions

## 📊 Logging & Monitoring

The bot creates detailed logs in the `Logs/bot1....` folder:

- `SEO_BOT.log` - Real-time activity log
- `session_progress.json` - Live progress tracking
- `session_final.json` - Complete session summary
- `verification_challenges.log` - Security challenge records

## 🛡️ Anti-Detection Features

- **Random User Agents** - Different browsers and devices
- **Browser Fingerprint Spoofing** - Avoids automation detection
- **Natural Timing** - Human-like delays between actions
- **Realistic Interactions** - Mouse movements, scrolling, clicking

## ⚠️ Important Notes

### ✅ Recommended Usage

- **Legitimate testing** of your own websites
- **SEO monitoring** and analytics verification
- **Load testing** and user behavior simulation
- **Educational purposes** for web analytics

### ❌ Prohibited Usage

- **Illegal activities** or harassment
- **Competitor manipulation** or malicious intent
- **Spam generation** or abusive behavior
- **Terms of service violations**

### ⚡ Performance Tips

- **Start small** with 1-2 URLs and short durations
- **Monitor logs** for any verification challenges
- **Use responsibly** to avoid overwhelming servers
- **Respect robots.txt** and website policies

## 🔧 Technical Requirements

- **Windows 10/11** (batch script optimized for Windows)
- **Python 3.11+** (automatically installed if missing)
- **Chrome Browser** (required for Selenium WebDriver)
- **Internet Connection** (for downloads and browsing)

## 📋 Dependencies

The bot automatically installs:

- `selenium` - Web browser automation
- `fake-useragent` - Random user agent generation
- `urllib3` - URL handling utilities

## 🆘 Troubleshooting

### Common Issues

1. **Python not found after installation**
   - Solution: Restart your computer and run `runBot.bat` again

2. **Chrome driver issues**
   - Solution: Ensure Chrome is installed and updated

3. **Verification challenges detected**
   - Solution: The bot will log these and may require manual intervention

4. **URL redirects happening**
   - Solution: The bot automatically detects and attempts to fix redirects

### Log Files Location

Check `SEO_BOT\Logs\` for detailed error information and session reports.

## 📄 License

This project is for educational and legitimate testing purposes only. Users are responsible for complying with all applicable laws and website terms of service.

## 🤝 Contributing

For improvements and bug reports, please ensure all contributions adhere to ethical usage guidelines.

---

**Remember**: Use this tool responsibly and only on websites you own or have explicit permission to test. Always respect website terms of service and robots.txt directives.
