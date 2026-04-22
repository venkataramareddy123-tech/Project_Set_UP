import asyncio
import httpx
from typing import List, Optional, Any
import logging

class AsyncFetcher:
    """Base class for high-concurrency data ingestion using httpx and asyncio."""
    
    def __init__(self, timeout: int = 30, concurrency_limit: int = 10):
        self.timeout = timeout
        self.semaphore = asyncio.Semaphore(concurrency_limit)
        self.client = httpx.AsyncClient(
            timeout=self.timeout,
            follow_redirects=True,
            headers={"User-Agent": "QuantumSurge-V2-Engine"}
        )

    async def fetch_url(self, url: str) -> Optional[bytes]:
        """Fetches a single URL with concurrency control."""
        async with self.semaphore:
            try:
                response = await self.client.get(url)
                response.raise_for_status()
                return response.content
            except Exception as e:
                logging.error(f"Error fetching {url}: {e}")
                return None

    async def fetch_all(self, urls: List[str]) -> List[Any]:
        """Fetches multiple URLs concurrently."""
        tasks = [self.fetch_url(url) for url in urls]
        return await asyncio.gather(*tasks)

    async def close(self) -> None:
        """Closes the underlying HTTP client."""
        await self.client.aclose()
