# Define variables
DOCKERUSER = userino

MAJOR = 9
MINOR = 6
PATCH = 3

DBSCHEMA_TAR = dbschema_$(MAJOR)_$(MINOR)_$(PATCH).tar.gz
DBSCHEMA_URL = https://www.dbschema.com/download/DbSchema_unix_$(MAJOR)_$(MINOR)_$(PATCH).tar.gz

# Default target
all: download extract

# Download the DbSchema `tar.gz` file if it doesn't exist
download:
	if [ ! -f $(DBSCHEMA_TAR) ]; then \
		curl -L $(DBSCHEMA_URL) --output $(DBSCHEMA_TAR); \
	fi

# Extract the downloaded `tar.gz` file
extract: $(DBSCHEMA_TAR)
	tar xvf $(DBSCHEMA_TAR)

# Clean up downloaded files (optional)
clean:
	rm -f $(DBSCHEMA_TAR)
	rm -rf DbSchema

.PHONY: all download extract clean
