
import SwiftUI

struct SettingsView: View {

    @State private var selectedIcon: AppIcon = .default

    enum AppIcon: String, CaseIterable {
        case `default`
        case dark
        case blue

        var title: String {
            switch self {
            case .default: return "Default"
            case .dark: return "Dark"
            case .blue: return "Blue"
            }
        }

        var previewImageName: String {
            switch self {
            case .default: return "DefaultIconPreview"
            case .dark: return "DarkIconPreview"
            case .blue: return "BlueIconPreview"
            }
        }

        var alternateIconName: String? {
            switch self {
            case .default: return nil
            case .dark: return "AppIcon-Dark"
            case .blue: return "AppIcon-Blue"
            }
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ForEach(AppIcon.allCases, id: \.self) { icon in

                        Button {
                            changeAppIcon(to: icon)
                        } label: {
                            HStack(spacing: 16) {

                                Image(icon.previewImageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 11)
                                    )

                                Text(icon.title)
                                    .foregroundStyle(.primary)

                                Spacer()

                                if selectedIcon == icon {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.tint)
                                }
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Text("App Icon")
                } footer: {
                    Text("Choose the app icon you want to display on your Home Screen.")
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                updateSelectedIcon()
            }
        }
    }

    // Synchronize the selection with the actual installed icon.
    private func updateSelectedIcon() {
        if UIApplication.shared.alternateIconName == "AppIcon-Dark" {
            selectedIcon = .dark
        } else {
            selectedIcon = .default
        }
    }

    private func changeAppIcon(to icon: AppIcon) {

        guard selectedIcon != icon else { return }

        // Check whether the application supports alternate icons.
        guard UIApplication.shared.supportsAlternateIcons else {
            print("Alternate icons are not supported.")
            return
        }

       
        UIApplication.shared.setAlternateIconName(icon.alternateIconName) { error in
            DispatchQueue.main.async {
                if let error {
                    print(
                        "Failed to change app icon: \(error.localizedDescription)"
                    )
                } else {
                    selectedIcon = icon
                    print("App icon changed to: \(icon.title)")
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
