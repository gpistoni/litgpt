cd ~/Projects/litgpt

mkdir -p custom_texts
curl https://www.gutenberg.org/cache/epub/1513/pg1513.txt --output custom_texts/ROMEO_JULIET.txt
curl https://www.gutenberg.org/cache/epub/84/pg84.txt --output custom_texts/FRANKESTEIN.txt
curl https://www.gutenberg.org/cache/epub/2600/pg2600.txt --output custom_texts/WAR_AND_PEACE.txt

.venv/bin/pip3 install transformer-engine[core]

.venv/bin/litgpt download microsoft/phi-2

.venv/bin/litgpt pretrain microsoft/phi-2 \
  --tokenizer_dir microsoft/phi-2 \
  --initial_checkpoint_dir microsoft/phi-2 \
  --data TextFiles \
  --data.train_data_path "custom_texts/" \
  --train.max_tokens 10_000_000 \
  --out_dir out/custom-model

 .venv/bin/litgpt chat out/custom-model/final