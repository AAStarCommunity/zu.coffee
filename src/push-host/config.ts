import { config as dotenvConfig } from 'dotenv';
dotenvConfig();

interface Config {
  port: number;
}

const config: Config = {
  port: parseInt(process.env.PORT || '3000', 10),
};

export default config;