.PHONY: help setup run stop restart update logs status delete

-include .env

CONTAINER_NAME ?= open-webui
IMAGE ?= ghcr.io/open-webui/open-webui:main
HOST_PORT ?= 3000
CONTAINER_PORT ?= 8080
DATA_VOLUME ?= open-webui
RESTART_POLICY ?= unless-stopped

BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
NC := \033[0m

help:
	@echo "$(BLUE)Open WebUI commands$(NC)"
	@echo "  make setup    - Validate docker and local env"
	@echo "  make run      - Start service in detached mode"
	@echo "  make stop     - Stop running service"
	@echo "  make restart  - Restart service"
	@echo "  make update   - Pull latest image and recreate service"
	@echo "  make logs     - Follow service logs"
	@echo "  make status   - Show service status"
	@echo "  make delete   - Remove service and data volume"

setup:
	@echo "$(BLUE)Checking Docker availability...$(NC)"
	@docker --version >/dev/null
	@docker compose version >/dev/null
	@if [ ! -f .env ]; then \
		echo "$(YELLOW).env not found. Create one with: cp .env.example .env$(NC)"; \
	else \
		echo "$(GREEN).env found$(NC)"; \
	fi
	@echo "$(GREEN)Setup check completed$(NC)"

run:
	@echo "$(BLUE)Starting Open WebUI...$(NC)"
	@docker compose up -d
	@echo "$(GREEN)Service started$(NC)"
	@echo "Open: http://localhost:$(HOST_PORT)"

stop:
	@echo "$(YELLOW)Stopping Open WebUI...$(NC)"
	@docker compose stop
	@echo "$(GREEN)Service stopped$(NC)"

restart:
	@echo "$(YELLOW)Restarting Open WebUI...$(NC)"
	@docker compose restart
	@echo "$(GREEN)Service restarted$(NC)"

update:
	@echo "$(BLUE)Updating Open WebUI image...$(NC)"
	@docker compose pull
	@docker compose up -d
	@echo "$(GREEN)Update complete$(NC)"

logs:
	@docker compose logs -f openwebui

status:
	@docker compose ps
	@echo ""
	@echo "Volume check:"
	@docker volume ls | grep -E "(^|[[:space:]])$(DATA_VOLUME)($|[[:space:]])" || echo "Volume not found"

delete:
	@echo "$(RED)WARNING: This will remove Open WebUI container and volume data.$(NC)"
	@read -p "Type 'yes' to continue: " confirm; \
	if [ "$$confirm" = "yes" ]; then \
		docker compose down -v; \
		echo "$(GREEN)Open WebUI removed (including volume data).$(NC)"; \
	else \
		echo "$(YELLOW)Cancelled.$(NC)"; \
	fi

.DEFAULT_GOAL := help
