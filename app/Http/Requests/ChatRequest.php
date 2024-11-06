<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ChatRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }
    
    protected function prepareForValidation(): void
    {
        $user_id = auth()->user()->id;
        $chat_id =  $this->route()->parameters['chat_id'] ?? null;
        $this->merge([
            'user_id' => $user_id,
            'chat_id'=>$chat_id,
        ]);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        switch(($this->route()->getName())){
            case 'chat.send':
                return[
                    "prompt" =>'required|string|max:500',
                    "file" => "nullable|file|mimes:txt,pdf,docx|max:2048"
                ];
            break;
            default:
                return[];
            break;
        }
    }
}
