import duckdb
from pathlib import Path
import logging

class DatabaseManager:
    """Manages the DuckDB connection and high-performance analytical storage."""
    
    def __init__(self, db_path: str = "data/quantum_surge.db"):
        self.db_path = db_path
        Path(db_path).parent.mkdir(parents=True, exist_ok=True)
        self.conn = duckdb.connect(database=self.db_path, read_only=False)
        self._initialize_schema()

    def _initialize_schema(self) -> None:
        """Initializes the database schema using DuckDB's optimized column store."""
        # Note: Specific column logic will be defined based on your plans
        self.conn.execute("""
            CREATE TABLE IF NOT EXISTS market_history (
                date DATE,
                symbol VARCHAR,
                series VARCHAR,
                open DOUBLE,
                high DOUBLE,
                low DOUBLE,
                close DOUBLE,
                volume BIGINT,
                delivery BIGINT,
                PRIMARY KEY (date, symbol, series)
            )
        """)
        logging.info("DuckDB Schema Initialized.")

    def get_connection(self) -> duckdb.DuckDBPyConnection:
        """Returns the active DuckDB connection."""
        return self.conn

    def close(self) -> None:
        """Gracefully closes the connection."""
        self.conn.close()
