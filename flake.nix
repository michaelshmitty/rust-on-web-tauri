{
  description = "TAURI demo devshell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            # Required MacOS frameworks:
            darwin.apple_sdk.frameworks.Cocoa
            darwin.apple_sdk.frameworks.Foundation
            darwin.apple_sdk.frameworks.WebKit

            # Probably not required MacOS frameworks:
            # darwin.apple_sdk.frameworks.AppKit
            # darwin.apple_sdk.frameworks.CoreFoundation
            # darwin.apple_sdk.frameworks.CoreServices
            # darwin.apple_sdk.frameworks.Security

            nodejs
            openssl
            pkg-config
            rust-bin.stable.latest.default
            nixpkgs-fmt
          ];
        };
      }
    );
}
