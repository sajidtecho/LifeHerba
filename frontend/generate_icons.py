import os
from PIL import Image

def generate_icons():
    logo_path = os.path.abspath("lib/assets/LifeHerba Logo.png")
    if not os.path.exists(logo_path):
        print(f"Error: Logo file not found at {logo_path}")
        return

    print(f"Opening original logo from: {logo_path}")
    original_img = Image.open(logo_path)

    # 1. Android Icons
    android_icons = {
        "android/app/src/main/res/mipmap-mdpi/ic_launcher.png": (48, 48),
        "android/app/src/main/res/mipmap-hdpi/ic_launcher.png": (72, 72),
        "android/app/src/main/res/mipmap-xhdpi/ic_launcher.png": (96, 96),
        "android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png": (144, 144),
        "android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png": (192, 192),
    }

    # 2. iOS Icons
    ios_icons = {
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png": (20, 20),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png": (40, 40),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png": (60, 60),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png": (29, 29),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png": (58, 58),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png": (87, 87),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png": (40, 40),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png": (80, 80),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png": (120, 120),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png": (120, 120),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png": (180, 180),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png": (76, 76),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png": (152, 152),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png": (167, 167),
        "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png": (1024, 1024),
    }

    # 3. Web Icons
    web_icons = {
        "web/favicon.png": (32, 32),
        "web/icons/Icon-192.png": (192, 192),
        "web/icons/Icon-512.png": (512, 512),
        "web/icons/Icon-maskable-192.png": (192, 192),
        "web/icons/Icon-maskable-512.png": (512, 512),
    }

    # Combine all icon sets
    all_icons = {}
    all_icons.update(android_icons)
    all_icons.update(ios_icons)
    all_icons.update(web_icons)

    print(f"Generating {len(all_icons)} icons...")

    for path, size in all_icons.items():
        abs_dest_path = os.path.abspath(path)
        os.makedirs(os.path.dirname(abs_dest_path), exist_ok=True)
        
        # High quality scaling with LANCZOS
        resized_img = original_img.resize(size, Image.Resampling.LANCZOS)
        
        # Save as PNG
        resized_img.save(abs_dest_path, "PNG")
        print(f"  Generated: {path} ({size[0]}x{size[1]})")

    print("Successfully generated all platform icons!")

if __name__ == "__main__":
    generate_icons()
