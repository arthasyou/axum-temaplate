file::delete("Cargo.toml");
file::rename("Template.toml", "Cargo.toml");
file:copy("config/services-example.toml", "config/services.toml")