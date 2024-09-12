# Define variables
DOCKERUSER = userino

MAJOR = 9
MINOR = 6
PATCH = 2

DBSCHEMA_TAR = dbschema_$(MAJOR)_$(MINOR)_$(PATCH).tar.gz
DBSCHEMA_URL = https://www.dbschema.com/download/DbSchema_unix_$(MAJOR)_$(MINOR)_$(PATCH).tar.gz

# Default target
all: download extract build

# Download thesudo make DbSchema tar.gz file if it doesn't exist
download:
	if [ ! -f $(DBSCHEMA_TAR) ]; then \
		curl -L $(DBSCHEMA_URL) --output $(DBSCHEMA_TAR); \
	fi

# Extract the downloaded tar.gz file
extract: $(DBSCHEMA_TAR)
	tar xvf $(DBSCHEMA_TAR)

# Build the Docker image
build:
	docker build -t "$(DOCKERUSER)/dbschema:v$(MAJOR).$(MINOR).$(PATCH)" .

# Clean up downloaded files (optional)
clean:
	rm -f $(DBSCHEMA_TAR)
	rm -rf DbSchema

.PHONY: all download extract build clean
