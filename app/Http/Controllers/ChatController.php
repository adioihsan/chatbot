<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;
use App\Http\Requests\ChatRequest;
use App\Models\Chat;
use App\Models\ChatHistory;
use OpenAI\Laravel\Facades\OpenAI;
use Illuminate\Support\Facades\DB;
use Imagick;
use Spatie\PdfToText\Pdf;
use Illuminate\Support\Facades\Storage;

class ChatController extends Controller
{
    public function index(Request $request): Response
    {
        return Inertia::render('Chat/Index');
    }
    // First Approach
    // pdf -> text -> chatgpt
    public function sendV1(ChatRequest $request){
        try {
            DB::beginTransaction();
            $prompt = $request->validated("prompt");
            $file = $request->validated("file");
            $response = ''; 

            if (isset($request->chat_id)) {
                $chat = Chat::find($request->chat_id);
            } else {
                $title = substr($prompt, 0, 30);
                $chat = Chat::create([
                    'user_id' => $request->user_id,
                    'title' => $title,
                ]);
            }
            if ($file) {

                //  Extract text from pdf
                $extractedText = $this->pdfToText($file->getRealPath());

                // Prepare prompt for chat
                $finalPrompt = "Document Content:\n" . $extractedText . "\n\nQuestion: " . $prompt;

                //  send to gpt
                $result = $this->createChatClient($finalPrompt);
                $response = $result->choices[0]->message->content;
            } else {
                $result = $this->createChatClient($prompt);
                $response = $result->choices[0]->message->content;
            }

            // Save chat history
            // ChatHistory::create([
            //     'chat_id' => $chat->id,
            //     'prompt' => $prompt,
            //     'response' => $response,
            // ]);

            DB::commit();
            return Inertia::render('Chat/Index', [
                "response" => $response,
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }

    // second Approach
    // pdf -> image-> text (ocr) ->chatgpt
    public function sendV2(ChatRequest $request){
        try {
            DB::beginTransaction();
            $prompt = $request->validated("prompt");
            $file = $request->validated("file");
            $response = ''; // Initialize response variable

            if (isset($request->chat_id)) {
                $chat = Chat::find($request->chat_id);
            } else {
                $title = substr($prompt, 0, 30);
                $chat = Chat::create([
                    'user_id' => $request->user_id,
                    'title' => $title,
                ]);
            }
            if ($file) {

                // Convert PDF to Images
                $imagePaths = $this->pdfToImages($file->getRealPath());

                // Extract text from the images
                $extractedText = $this->extractTextFromImages($imagePaths);

                // Prepare prompt for chat
                $finalPrompt = "Document Content:\n" . $extractedText . "\n\nQuestion: " . $prompt;

                // Send to GPT
                $result = $this->createChatClient($finalPrompt);
                $response = $result->choices[0]->message->content;
            } else {
                $result = $this->createChatClient($prompt);
                $response = $result->choices[0]->message->content;
            }

            // Save chat history
            // ChatHistory::create([
            //     'chat_id' => $chat->id,
            //     'prompt' => $prompt,
            //     'response' => $response,
            // ]);

            DB::commit();
            return Inertia::render('Chat/Index', [
                "response" => $response,
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }
    
    // Third Approach
    // pdf -> imageBase64 -> chatgpt
    public function sendV3(ChatRequest $request)
    {
        try {
            DB::beginTransaction();
            $prompt = $request->validated("prompt");
            $file = $request->validated("file");
            $response = ''; // Initialize response variable

            if (isset($request->chat_id)) {
                $chat = Chat::find($request->chat_id);
            } else {
                $title = substr($prompt, 0, 30);
                $chat = Chat::create([
                    'user_id' => $request->user_id,
                    'title' => $title,
                ]);
            }
            if ($file) {
                //  Convert pdf to images base64,
                $images = $this->pdfToImagesBase64($file->getRealPath());

                //  Prepare prompt with
                $images_prompt = array_map(function($image_url){
                    return       [
                        "type"=> "image_url",
                        "image_url"=> [
                            "url"=>  $image_url,
                        ],
                    ];
                },$images);
 
                $prompt = [
                    [
                        "type"=>"text",
                        "text"=> $request->validated("prompt"),
                    ]
                ];
                $finalprompt = array_merge($prompt,$images_prompt);
                
                // Send prompt to GPT
                $result = $this->createChatClient($finalprompt);
                $response = $result->choices[0]->message->content;
            } else {
                $result = $this->createChatClient($prompt);
                $response = $result->choices[0]->message->content;
            }

            // Save chat history
            // ChatHistory::create([
            //     'chat_id' => $chat->id,
            //     'prompt' => $prompt,
            //     'response' => $response,
            // ]);

            DB::commit();
            return Inertia::render('Chat/Index', [
                "response" => $response,
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }

    // Fourth Approacj
    // pdf-> image -> cloud storage -> chatgpt
    public function sendV4(ChatRequest $request)
    {
        try {
            DB::beginTransaction();
            $prompt = $request->validated("prompt");
            $file = $request->validated("file");
            $response = ''; // Initialize response variable

            if (isset($request->chat_id)) {
                $chat = Chat::find($request->chat_id);
            } else {
                $title = substr($prompt, 0, 30);
                $chat = Chat::create([
                    'user_id' => $request->user_id,
                    'title' => $title,
                ]);
            }
            if ($file) {
                //  Convert pdf to images ,
                $image_paths = $this->pdfToImages($file->getRealPath());
                $image_urls = $this->uploadImagesToS3($image_paths);
                //  Prepare prompt with
                $images_prompt = array_map(function($image_url){
                    return       [
                        "type"=> "image_url",
                        "image_url"=> [
                            "url"=>  $image_url,
                        ],
                    ];
                },$image_urls);
 
                $prompt = [
                    [
                        "type"=>"text",
                        "text"=> $request->validated("prompt"),
                    ]
                ];
                $finalprompt = array_merge($prompt,$images_prompt);
                
                // Send prompt to GPT
                $result = $this->createChatClient($finalprompt);
                $response = $result->choices[0]->message->content;
            } else {
                $result = $this->createChatClient($prompt);
                $response = $result->choices[0]->message->content;
            }

            // Save chat history
            // ChatHistory::create([
            //     'chat_id' => $chat->id,
            //     'prompt' => $prompt,
            //     'response' => $response,
            // ]);

            DB::commit();
            return Inertia::render('Chat/Index', [
                "response" => $response,
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }

    private function createChatClient($prompt)
    {
        return OpenAI::chat()->create([
            'model' => 'gpt-4o-mini',
            'messages' => [
                ['role' => 'user', 
                'content' => $prompt],
            ],
        ]);
    }

    private function pdfToText($pdfPath){
        return Pdf::getText($pdfPath);
    }

    private function pdfToImages($pdfPath)
    {
        $images = [];
        $imagick = new Imagick();
        $imagick->setResolution(200, 200);
        $imagick->readImage($pdfPath);

        foreach ($imagick as $pageNumber => $page) {
            $page->setImageFormat('jpeg');
            $page->setImageCompressionQuality(75);
            $tempImagePath = sys_get_temp_dir() . "/page_{$pageNumber}_" . uniqid() . ".jpeg";
            $page->writeImage($tempImagePath);
            $images[] = $tempImagePath;
        }

        $imagick->clear();
        $imagick->destroy();
        return $images; 
    }

    private function pdfToImagesBase64($pdfPath)
    {
        $images = [];
        $imagick = new \Imagick();
        $imagick->setResolution(300, 300);
        $imagick->readImage($pdfPath);

        foreach ($imagick as $pageNumber => $page) {
            $page->setImageFormat('jpeg');

            // Get image blob and convert it to base64
            $imageBlob = $page->getImageBlob();
            $base64Image = base64_encode($imageBlob);

            $images[] = 'data:image/jpeg;base64,' . $base64Image; 
        }

        $imagick->clear();
        $imagick->destroy();

        return $images; // 
    }

    private function extractTextFromImages(array $imagePaths)
    {
        $text = '';
        foreach ($imagePaths as $imagePath) {
            $output = shell_exec("tesseract {$imagePath} stdout");
            $text .= $output . "\n\n";
        }
        return $text;
    }

    private function uploadImagesToS3(array $imagePaths){
        $urls = [];
        foreach($imagePaths as $path){
            $filename = basename($path);
            Storage::disk('s3')->put($filename ,file_get_contents($path),'public');
            $urls[] = Storage::disk('s3')->url($filename);
        }
        return $urls;
    }
    
    // public function createAssistantClient()
    // {
    //     return OpenAI::assistants()->create([
    //         'instructions' => 'Summarize the content of the contract vector store',
    //         'name' => 'Summarizer',
    //         'tools' => [
    //             [
    //                 'type' => 'file_search',
    //             ],
    //         ],
    //         'model' => 'gpt-4',
    //     ]);
    // }
    
    // public function uploadFile($file){
    //     $response = OpenAI::files()->upload([
    //         'purpose' => 'assistants',
    //         'file' => fopen($file->getRealPath(), 'r'),
    //     ]);
    
    //     $file_id = $response->id;
    //     OpenAI::vectorStores()->batches()->create(
    //         vectorStoreId: 'vs_fb1i4pMrIPp2Qa0kBekpQakJ',
    //         parameters: [
    //             'file_ids' => [
    //                 $file_id
    //             ],
    //         ]
    //     );
    // }
}
